Install Cisco Packet Tracer on Ubuntu

Before You Begin:
Download the Cisco Packet Tracer .deb installer from Cisco NetAcad.


Running the Script:

Preferred Method:
Open a terminal window.
type: sudo bash <- should be a space after 
Go to where you downloaded PacketTracer
Drag and drop the file into the terminal
Should look like this:
sudo bash '/home/foobar/Downloads/PackeTracerInstallScript.sh"
[PRESS ENTER]

Second Method:
Open a terminal window.
Navigate to the directory where you saved the script (cd).
Make the script executable: chmod +x PackeTracerInstallScript.sh
Run the script: ./PackeTracerInstallScript.sh

The Script Does:

Updates your system packages.
Installs necessary dependencies.
It guides you to select the downloaded Packet Tracer .deb file.
Installs Packet Tracer.

If there are errors:
The script will notify you. Check the terminal window for details.

[!!Disclaimer!!]
Use at your own risk. This script is provided as-is.
Ensure you have downloaded the Packet Tracer .deb file before running the script.
This simplified version focuses on the essential steps and omits some technical details for a more user-friendly experience.
