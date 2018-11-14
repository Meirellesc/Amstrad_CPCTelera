<?PHP
//programmation Kukulcan
$file[1]  = "over1.SNA";
$file[2]  = "over2.SNA";
$file[3]  = "over3.SNA";
$file[4]  = "over2.SNA";
$file[5]  = "over1.SNA";

$total = count($file);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="pragma" content="no-cache" />
<title>COMPARE OVERSCAN</title>
<style type="text/css" media="print, projection, screen, tv">
body
{
 margin: 0px;
 background: SteelBlue;
}
.discology
{
 font-family: monospace;
 white-space:pre;
}
.module
{
 margin-top:10px;
 margin-left: 10px;
 float:left;
}
</style>
</head>
<body>
<?PHP
function ReadBinaireToHexadecimal($valeur)
{
 return sprintf("%02X", ord($valeur));
}
function ReadBinaireToDecimal($valeur)
{
 return sprintf("%03d", ord($valeur));
}

for ($i=1;$i<=$total;$i++)
{
	$part[$i] = file_get_contents($file[$i]);
}


$gain = 0;
$octets = 0;
for ($j=1;$j<=$total-1;$j++)
{
	unset($donnees);
	//---------------
	//--- TABLEAU ---
	//---------------
	echo "<div style=\"clear:both;\">&nbsp;</div>";

	//on lit la taille du 1er fichier qu'on considère comme la taille de référence (tous doivent avoir la même taille)
	$taille = 0x7E00;//ce qui nous intéresse va de &200 a &8000

	//&200 debut mémoire - &100 entete et hop on commence la lecture en &300 - &100 et on obtient l'adresse réelle a l'écran
	echo "<div class='discology'>FRAME".$j." ;comparaison ".$file[($j+1)]." et ".$file[$j];
	for ($i=0x300; $i<$taille; $i++)
	{
		if ( ReadBinaireToHexadecimal($part[$j][$i]) != ReadBinaireToHexadecimal($part[$j+1][$i]) )
		{
			//echo "LD A,&".ReadBinaireToHexadecimal($part[$j+1][$i]).":LD (&".sprintf("%04X", $i-(0x100))."),A";
			$valeur = ReadBinaireToDecimal($part[$j+1][$i]).":LD (&".sprintf("%04X", $i-(0x100))."),A";//decimal 3 digits
			$donnees[$valeur] = $valeur;
		}
	}
	echo "</div>";

	//-----------
	//--- TRI ---
	//-----------
	sort($donnees);
	$a = -3;
	foreach ($donnees as $value)
	{
		$lire = explode (":",$value);
		$b = $lire[0];
		if ($b != $a)
		{
			if ($b == 0)
			{
				echo "<br />XOR A:".$lire[1];
				$gain++;//gain 1 octet
				$octets+=4;
			}
			else if ($b == ($a + 1) )
			{
				//valeur suivant +1
				echo "<br />INC A:".$lire[1];
				$gain++;//gain 1 octet
				$octets+=4;
			}
			else
			{
				echo "<br />LD A,&".sprintf("%02X", ((int) $b)).":".$lire[1];
				$octets+=5;
			}
			$a=$b;
		}
		else
		{
			echo "<br />".$lire[1];
			$gain+=2;//gain 2 octets
			$octets+=3;
		}
	}
	echo "<br />RET<br />";
	$octets++;
}

echo "<br /><br />Gain = ".$gain;
echo "<br />Octets = ".$octets
?>
</body>
</html>