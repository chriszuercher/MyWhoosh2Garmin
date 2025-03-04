<h1 align="center" id="title">myWhoosh2Garmin</h1>

<h2>🧐Features</h2>

*   Finds the .fit files from your MyWhoosh installation.
*   Fix the missing power & heart rate averages.
*   Removes the temperature.
*   Create a backup file to a folder you select.
*   Uploads the fixed .fit file to Garmin Connect.

<h2>🛠️ Installation Steps:</h2>

<p>1. Download myWhoosh2Garmin.py and MyWhoosMonitor.ps1 to your filesystem to a folder or your choosing.</p>

<p>2. Go to the folder where you downloaded the script in a shell.</p>

- <b>MacOS:</b> Terminal of your choice. 
- <b>Windows:</b> Start > Run > cmd or Start > Run > powershell

You can directly call the PowerShell script if you have the required tools installed (see automation tips). This will setup a python venv and install all required packages.

```powershell
.\MyWhooshMonitor.ps1
```

<p>3. Install `pipenv` (if not already installed):</p>

```
pip3 install pipenv
or
pip install pipenv
```
<p>4. Install dependencies in a virtual envioronment:</p>

```
pipenv install
```

<p>5. Activate the virtual environment:</p>

```
pipenv shell
```

<p>5. Run the script:</p>

```
python3 myWhoosh2Garmin.py
or
python myWhoosh2Garmin.py
```

  
<p>6. Choose your backup folder.</p>

<h3>MacOS</h3>

![image](https://github.com/user-attachments/assets/2c6c1072-bacf-4f0c-8861-78f62bf51648)


<h3>Windows</h3>


![image](https://github.com/user-attachments/assets/d1540291-4e6d-488e-9dcf-8d7b68651103)

<p>7. Enter your Garmin Connect credentials</p>

```
2024-11-21 10:08:04,014 No existing session. Please log in.
Username: <YOUR_EMAIL>
Password:
2024-11-21 10:08:33,545 Authenticating...

2024-11-21 10:08:37,107 Successfully authenticated!
```

<p>8. Run the script when you're done riding or running.</p>

```
2024-11-21 10:08:37,107 Checking for .fit files in directory: <YOUR_MYWHOOSH_DIR_WITH_FITFILES>.
2024-11-21 10:08:37,107 Found the most recent .fit file: MyNewActivity-3.8.5.fit.
2024-11-21 10:08:37,107 Cleaning up <YOUR_BACKUP_FOLDER>yNewActivity-3.8.5_2024-11-21_100837.fit.
2024-11-21 10:08:37,855 Cleaned-up file saved as <YOUR_BACKUP_FOLDER>MyNewActivity-3.8.5_2024-11-21_100837.fit
2024-11-21 10:08:37,871 Successfully cleaned MyNewActivity-3.8.5.fit and saved it as MyNewActivity-3.8.5_2024-11-21_100837.fit.
2024-11-21 10:08:38,408 Duplicate activity found on Garmin Connect.
```

<p>(9. Or see below to automate the process)</p>

<h2>ℹ️ Automation tips</h2> 

What if you want to automate the whole process:
<h3>MacOS</h3>

PowerShell on MacOS (Verified & works)

You need Powershell

```shell
brew install powershell/tap/powershell
```

Start the script. This will also setup a virtual python environment and starts monitoring the application.

```powershell
.\MyWhooshMonitor.ps1
```

AppleScript (need to test further)

```applescript
TODO: needs more work
```

<h3>Windows</h3>


You can simply start the monitor by doubleclick the ```StartMyWooshMonitor.bat``` file which will execute PowerShell with the script.

If you prefer PowerShell you can start the script. This will also setup a virtual python environment and starts monitoring the application.

```powershell
.\MyWhooshMonitor.ps1
```



<h2>💻 Built with</h2>

Technologies used in the project:

*   Neovim
*   [Garth](https://github.com/matin/garth)
*   [tKinter](https://github.com/TomSchimansky/CustomTkinter)
*   [Fit\_tool](https://github.com/stuartlynne/python_fit_tool)

