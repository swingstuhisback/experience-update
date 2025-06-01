@echo off
net stop wuauserv
net stop bits
net stop cryptsvc
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
rd /s /q "%WinDir%\System32\GroupPolicy"
rd /s /q "%WinDir%\System32\GroupPolicyUsers"
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f
net start wuauserv
net start bits
net start cryptsvc
net start msiserver
gpupdate /force
powershell -Command "Remove-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Recurse -Force -ErrorAction SilentlyContinue"
powershell -Command "Remove-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate' -Recurse -Force -ErrorAction SilentlyContinue"
