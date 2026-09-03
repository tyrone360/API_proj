using Microsoft.Data.SqlClient;
using System.Reflection.Metadata;

namespace API_proj.Backed
{//start of namespace
    public class dataCollected
    {//start of class


        public string personal_Information(string name, string surname, int age) {


            string message = " ";

            string connection_string = @"Data source=(localdb)\API_proj;database=API_proj";

            //catching error message

            try
            {//start of try
                //using a sql server instance that we created
                using (SqlConnection CONNECT = new SqlConnection(connection_string))

                {//start of using
                    //open connection

                    CONNECT.Open();

                    String query = @"Insert into table_user('" + name + "', '" + surname + "', " + age + ");";

                    SqlCommand run_query = new SqlCommand(query, CONNECT);

                    run_query.ExecuteNonQuery();

                    message = "user successfully registered";

                    CONNECT.Close();
                }//end of using

            }//end try


            catch (Exception error)
            {//start of catch

                message = error.Message;



            }//end of catch

            return message;
        }//end method

    }//end of class
}//end of namespace
