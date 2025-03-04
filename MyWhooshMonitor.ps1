# Validate path or search if not found
if (-not $myWhooshPath -or -not (Test-Path $myWhooshPath)) {
    if ([System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Unix) {
        # macOS search
        $myWhooshApp = "myWhoosh Indoor Cycling App.app"
        Write-Host "Searching for $myWhooshApp..."
        $appBundle = Get-ChildItem -Path "/Applications" -Filter $myWhooshApp -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($appBundle) {
            $myWhooshPath = "$($appBundle.FullName)/Contents/MacOS/MyWhoosh Indoor Cycling App"
        }
    } elseif ([System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Win32NT) {
        # Windows search
        $myWhooshApp = "MyWhoosh"
        Write-Host "Searching for $myWhooshApp App.."
        $appxPackage = Get-AppxPackage | Where-Object { $_.Name -like "*$myWhooshApp*" }
        if ($appxPackage) {
            $installLocation = $appxPackage.InstallLocation
            Write-Host "Found install location: $installLocation"

            # Search for MyWhoosh.exe in the correct subdirectory

            # $myWhooshPath = Get-ChildItem -Path $installLocation -Filter $myWhooshApp -Recurse -ErrorAction SilentlyContinue |
            #     Select-Object -First 1 -ExpandProperty FullName
            $startApp = (Get-StartApps | Where-Object { $_.Name -like "*$myWhooshApp*" })
            if($startApp) {
                $appId = $startApp.AppID
                $myWhooshPath = "shell:AppsFolder\$appId"
            }
        }
    }

    if (-not $myWhooshPath) {
        Write-Error "MyWhoosh.exe not found!"
        exit 1
    }
}

Write-Host "Starting $myWhooshApp : $myWhooshPath"

$processName = if ([System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Unix) {
    "MyWhoosh Indoor Cycling App"
} else {
    "MyWhoosh"
}

# Start the application
if ([System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Win32NT) {
    Start-Process -FilePath "explorer.exe" -ArgumentList $myWhooshPath -NoNewWindow -PassThru
} else {
    # Open only if not already running - MacOS
    if (-not (ps -e | grep "$processName" | grep -v "grep")) {
    	Start-Process -FilePath $myWhooshPath -NoNewWindow -PassThru
    }
    else {
        Write-Host "$myWhooshApp is already running"
    }
}

Start-Sleep -Seconds 10

# Wait for the app to finish
Write-Host "Waiting for $processName to finish..."
while (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
    Start-Sleep -Seconds 5
}

# Run the Python script after MyWhoosh exits
$venvPath = if ([System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Unix) {
    "./.venv/bin/python"
} else {
    ".\.venv\Scripts\python.exe"
}

if (Test-Path $venvPath) {
    Write-Host "Running Python script in VENV..."
    & $venvPath myWhoosh2Garmin.py
} else {
    Write-Host "VENV not found. Creating VENV..."
    python -m venv .venv
    Write-Host "VENV created. Installing required packages..."
    if ([System.Environment]::OSVersion.Platform -eq [System.PlatformID]::Unix) {
        & ./.venv/bin/python -m pip install -r requirements.txt
    } else {
        & .\.venv\Scripts\python.exe -m pip install -r requirements.txt
    }
    Write-Host "Running Python script in VENV..."
    & $venvPath myWhoosh2Garmin.py
}