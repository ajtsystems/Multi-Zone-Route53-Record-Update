$zones = get-R53HostedZones
Foreach ($z in $zones){

#Cname name (text before the domain - e.g. 'proxy'
$cname = "Proxy."
#Domain part of the name
$cnamedomain = $cname + $z.name

#Parses the HostedZone ID from the $zones
$hostedZoneIDB4 = $z.id 
$hostedZoneID = $hostedZoneIDB4.split('/')[2]

$change1 = New-Object Amazon.Route53.Model.Change
$change1.Action = "CREATE"
$change1.ResourceRecordSet = New-Object Amazon.Route53.Model.ResourceRecordSet
$change1.ResourceRecordSet.Name = $cnamedomain
$change1.ResourceRecordSet.Type = "CNAME"
$change1.ResourceRecordSet.TTL = 600
$change1.ResourceRecordSet.ResourceRecords.Add(@{Value="123.example.com"})


$params = @{
    HostedZoneId=$hostedZoneID
	ChangeBatch_Comment="Date and reason for new record!"
	ChangeBatch_Change=$change1
	}
		}

Edit-R53ResourceRecordSet @params




