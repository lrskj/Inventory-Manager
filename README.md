Please carefully read the following in order to make use of the accompanying files. 
These are detailed instructions on how to set up and run the Wine Shop Reports application. 
This application is Python-based, and will generate reports from a MySQL database for use 
in your wine shop. 

<PREREQUISITES>

Before running the application, you need to have the following installed on your computer:

Python: The application is written in Python. If you do not have Python installed, download and install it from python.org.

MySQL Server: The application connects to a MySQL database. Ensure you have MySQL Server installed and running on your computer. If not, you can download it from MySQL official site.

MySQL Connector for Python: This is a library that allows Python to communicate with MySQL. You can install it via pip (Python's package installer). Instructions are provided in the "Installation" section below.


<INSTALLATION>

Install MySQL Connector: Open your command prompt or terminal and run the following command:

Copy code
pip install mysql-connector-python
Download the Application: Download the Python script provided for the reports (usually named something like wine_shop_reports.py) to a known location on your computer.


<SETUP>

Database Credentials: Open the Python script using a text editor (such as Notepad, TextEdit, or any code editor).

Edit Database Connection Details: Locate the connect_to_database function in the script and update the following details with your own MySQL database credentials:

host: Your database host (usually localhost or 127.0.0.1).
user: Your MySQL username.
passwd: Your MySQL password.
database: The name of your database.
It should look something like this:

python
Copy code
def connect_to_database():
    return mysql.connector.connect(
        host='localhost',
        user='your_username',
        passwd='your_password',
        database='your_database'
    )


<RUNNING THE APPLICATION>

Open Command Prompt or Terminal: Navigate to the folder where you saved the script.

Run the Script: Type the following command and press Enter:

Copy code
python wine_shop_reports.py
Follow On-Screen Prompts: For Report 3, you will be asked to enter a Supplier ID. Type a number and press Enter.


<UNDERSTANDING THE REPORTS>

The application generates three reports:

Report 1 - Supplier Information: Displays a list of suppliers with their IDs, names, and contact information.

Report 2 - Wine and Supplier Information: Shows details of wines, including their name, type, vintage, and the name of their supplier.

Report 3 - Wines from a Specific Supplier: After you input a Supplier ID, this report shows all wines supplied by that particular supplier.

Each report includes the date it was generated.


<TROUBLESHOOTING>

Python Not Recognized: If you get an error saying Python is not recognized, ensure Python is correctly installed and added to your system's PATH.

MySQL Connection Issues: If the application cannot connect to the MySQL database, verify that MySQL Server is running and your connection details are correct.

Module Not Found: If you get an error about missing mysql-connector-python, make sure you have run the installation command provided in the "Installation" section.
