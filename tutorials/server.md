# Server

[> GTA-v3](../../README.md) [> Tutorials](../README.md)
* * *

1. creazione droplet su digital-ocean
2. accesso al droplet con PuTTY da Windows ([https://www.putty.org/](https://www.putty.org))
3. creazione di un dominio di 3° livello
4. installazione certificato SSL con let's-encrypt [https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04](https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04)
5. installazione LAMP (Linux-Apache-Mysql-Php) [https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-20-04](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-20-04)
6. installazione Postgres [https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-20-04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-20-04)
7. installazione pgadmin [https://www.digitalocean.com/community/tutorials/how-to-install-configure-pgadmin4-server-mode](https://www.digitalocean.com/community/tutorials/how-to-install-configure-pgadmin4-server-mode)
8. installazione postgis [https://postgis.net/docs/manual-3.2/postgis\_installation.html](https://postgis.net/docs/manual-3.2/postgis\_installation.html)
9. [https://computingforgeeks.com/how-to-install-postgis-on-ubuntu-linux/](https://computingforgeeks.com/how-to-install-postgis-on-ubuntu-linux/)

## Enable PDO Postgres

```
sudo apt-get install php libapache2-mod-php
sudo apt-get install php-pgsql php-pdo_pgsql
sudo apt-get install php-mbstring php-zip php-gd php-json php-curl
--
sudo phpenmod pdo_mysql
sudo phpenmod pdo_pg
OR
sudo phpenmod pdo_pgsql
sudo phpenmod mbstring
--
sudo systemctl restart apache2
```

## Test connessione PDO Postgres

credential.php

```php
<?php
define('DBNAME','mydb');
define('HOST','localhost');
define('PORT','5432');
define('DBUSER','ubuntu');
define('PSWD','12345678');
?>
```

```php
<?php

require_once('credential.php');

function connessione_pdo_postgres(){
  $dbname=DBNAME;
  $host = HOST;
  $port = PORT;
  $user = DBUSER;
  $password = PSWD;
  $dbh = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
  return $dbh;
}
?>
```

### page.php

```php
<?php
header('Content-type: application/json');

$o=array(
  'type'=>'FeatureCollection',
  'features'=>array()
);

$dbh = connessione_pdo_postgres();
//--
$pgsql = "
  SELECT *
  FROM mytable
  LIMIT 10
";
$sth = $dbh->prepare($pgsql);
$sth->execute();
$pgrows = $sth->fetchAll();
//--
$dbh = null; // CLOSE CONNECTION
//--

foreach ( $pgrows as $pgobj ) :
    
  $p=array();
  
  $p['pid'] = $pgobj['pid'];
  //$g = json_decode($pgobj['geojson'], true); 

  $marker = array(
    'type' => 'Feature',
    'properties' => $p,
    //'geometry' => $g
  );

  $o['features'][] = $marker;
  unset($marker);      
endforeach;//$pgrows  

//--
echo json_encode($o,JSON_PRETTY_PRINT);
exit;

?>
```
