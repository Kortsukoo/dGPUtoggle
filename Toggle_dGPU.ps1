# Run as Admin

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
} 



# Checks dGPU state and either enables or disables it.

if (Get-PnpDevice | where {$_.friendlyname -like "NVIDIA*" -and $_.Status -eq "Error"}) {
Get-PnpDevice| where {$_.friendlyname -like "NVIDIA GeForce GTX 1060 with Max-Q Design*"} | Enable-PnpDevice -Confirm:$false
}
else {Get-PnpDevice| where {$_.friendlyname -like "NVIDIA GeForce GTX 1060 with Max-Q Design*"} | Disable-PnpDevice -Confirm:$false}