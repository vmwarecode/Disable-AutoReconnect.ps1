Import-module ActiveDirectory
$obj = Get-ADObject -LDAPFilter "(&(objectClass=pae-Prop)(pae-NameValuePair=alwaysConnect=1))" -SearchBase "OU=Properties,DC=vdi,DC=vmware,DC=int" -Properties distinguishedName,pae-NameValuePair -server localhost:389
if ($obj -ne $null)  {
    Set-ADObject -Identity $obj.distinguishedName -server localhost:389 -Remove @{'pae-NameValuePair'="alwaysConnect=1"}
    Set-ADObject -Identity $obj.distinguishedName -server localhost:389 -Add @{'pae-NameValuePair'="alwaysConnect=0"}
}