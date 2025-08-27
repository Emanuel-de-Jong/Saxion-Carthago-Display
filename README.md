# Carthago Display
For the class: 2.1 Project Persistent

Carthago display is a customizable TV information system build for Carthago ICT.

**Active Development:** 2021-08-30 - 2021-09-24<br>
**Last Change:** 2021-09-24<br>

| | |
| :---: | :---: |
| ![](/Screenshots/1-Slideshow.png) | ![](/Screenshots/2-Settings.png) |
| ![](/Screenshots/3-Slides.png) | ![](/Screenshots/4-Grid_Setting.png) |
| ![](/Screenshots/5-Slide_Settings.png) | ![](/Screenshots/.png) |

### Features
- Show meeting room occupancy
- Show upcoming events
- Show customizable RSS feeds 
- Show information about new employees
- Create a spotify playlist on chosen events
- Welcome guests with a greeting message
- Create custom components using HTML, CSS and JS
- Customizable layouts

## First Start

<details><summary>1. Insert main settings</summary>

- Slide Time: This is the time (In seconds) between slides.
- Host URL: This must be the current URL (Example: http://192.168.1.1:8080)

</details>
<details><summary>2. Insert the Outlook API settings</summary>

1. To make this application work, you need to register a APP in the Azure Active Directory.
 You can follow this tuturial to register a new APP: https://docs.microsoft.com/en-us/graph/auth-register-app-v2
2. Supported account types: You select "Single tenant" if you're currently logged in on the Carthago Display office 365 envermient, and "Any Azure AD directory - Multitenan" if your logged in somewhere else.
3. Redirect URI: You insert any URL pointed to the Carthago display Application.
4. After this you have to set the permission scope (You can do this bij selecting the "API permissions" in the left menu)
 The needed permissions are (From the Microsoft Graph API):
    - Calendars.Read
    - Calendars.ReadWrite
5. Now you can create a Client Secret. You can do this by going to the "Certificates & secrets" option in the left menu.
4. In the Carthago Display Application you can fill in the following settings:
    - Tenant ID: You can vind the ID by following the tutorial: https://o365hq.com/faq/how-to-find-your-office-365-tenant-id/
    - API Client ID: you can find this on the overview page of the API you just created.
    - API Client Secret: This is the Secret you just created.
    - API Redirect URL: This should be the same URL that you inserted when you created the API
    - Admin Email: this should be your Carhago Outlook Email (
    assuming that you are a Office 365 Admin)
</details>
<details><summary>3. Insert event API settings</summary>

- Calander Owner Email: This should be the email of the Creater of the Event Calander
- Calander Name: This should be the name of the Event Calander
- Borrel Event name: This should be the name of the Borrel Event

</details>

<details><summary>4. Insert Spotify API settings</summary>

To make this application work, you first have to registrate the a Spotify API.
1. Go to https://developer.spotify.com/dashboard/ and login.
2. Press on "CREATE AN APP".
3. Give the app a name and a description
4. Press on "EDIT SETTINGS"
5. Here you can add a "Redirect URL" insert the Host URL and add the following "/api/spotify/callback" and press save
6. Now you can copy the Client ID and Client Secret and fill in the settings fields.

For the Playlist name you can insert a fun name (This name will be used for the auto generated playlist)
</details>

## Setup
<details><summary>Production</summary>
In the current configuration, Carthago display is made to run on a RPI (Raspberry pi) running Raspbian.

1. Install Docker and Docker-compose on the RPI (https://dev.to/elalemanyo/how-to-install-docker-and-docker-compose-on-raspberry-pi-1mo).
2. Clone the project Repo.
3. CD to the project direcotry.
4. Run the command: `cd Docker && sudo docker-compose up --build -d` (This can take a long time).
5. Now you can connect to the Database using a MySQL client and run the SQL file found in the `[Project root]/Database`.
6. After this the application should be running and be accessible by inserting the IP of the RPI in the browser.

</details>

<details><summary>Development</summary>

1. Clone the project repo.
2. Run the following command (Assuming you already installed docker): `docker volume create carthago_mysql && docker run --name Carthago-mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=CarthagoDB -v carthago_mysql:/var/lib/mysql -p 3306:3306 -d mysql:5.7`.
3. Open the solution in visual studio.
4. Create the database by running the following commands in the package manager console (Tools > NuGet Package Manager > Package Manager Console):
    - `Add-Migration Init`
    - `Update-Database`
5. Now you can start developing.

</details>

</details>
