Installeer Docker
Voer het volgende commando in een terminal uit:
docker volume create carthago_mysql && docker run --name Carthago-mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=CarthagoDB -v carthago_mysql:/var/lib/mysql -p 3306:3306 -d mysql:5.7

Installeer Visual Studio Community
Dubbelklik Code\CarthagoDisplay\CarthagoDisplay.sln
Open PMC (Tools > NuGet Package Manager > Package Manager Console)
Creëer de database door de volgende commandos in PMC uit te voeren:
Add-Migration DB
Update-Database

Voor Mac en Linux gaat het maken van een migratie iets moeilijker:
https://stackoverflow.com/questions/45382536/how-to-enable-migrations-in-visual-studio-for-mac
