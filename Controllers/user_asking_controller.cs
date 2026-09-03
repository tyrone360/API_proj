using API_proj.Backed;
using Microsoft.AspNetCore.Mvc;

namespace API_proj.Controllers
{//start of namespace

    [Route("API/[controller]")]
    [ApiController]

    public class user_asking_controller : ControllerBase
    {//start of class


        [HttpPost]

        public string Backed(string connection)
        {//start of controll

            //try and catch
            //connect tot the database

            connection = "";

            return connection;

        }//end controller

        [HttpGet]

        public string User_Info(string name, string surname, int age) {

            dataCollected store_data = new dataCollected();

            string message = store_data.personal_Information(name, surname, age);

            return "This is your name " + name + "This is your surname " + surname + "This is your age" + age;



        }//end of controller
    }//end of class
}//end of namespace
