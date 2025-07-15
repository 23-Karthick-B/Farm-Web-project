import initSqlConnection from "../models/database.js"

const con = initSqlConnection()

async function validateUser(req, res) {
    const { choice, formType, username, name, contact, password, street, district, pincode } = req.body
    let details

    if (formType == "login") {
        if (choice === "farmer") {
            [details] = await con.query('SELECT * FROM farmers WHERE User_Name = ? AND Password = ?', [req.body.username, req.body.password])
        }
        if (choice === "consumer") {
            [details] = await con.query('SELECT * FROM consumers WHERE User_Name = ? AND Password = ?', [req.body.username, req.body.password])
            console.log(details);

        }


        console.log(details[0])
        if (!details[0]) {
            return { redirect: '/', alertMessage: "you didn't signup" }

        } else {

            return { redirect: `/${choice}/${username}`, pincode: details[0].Pincode }

        }
    }

    if (formType == "signup") {

        if (choice == 'farmer') {
            const [user] = await con.query('select User_Name from farmers where User_Name=?', [username])
            if (user[0].User_Name == username) {
                console.log('user aldready exits')
                return { redirect: '/', alertMessage: "farmer aldready exists" }

            } else {
                await con.query('insert into farmers (User_Name,Name,Street,District,Pincode,Contact_Number,Password) values(?,?,?,?,?,?,?)', [username, name, street, district, pincode, contact, password])
                return { redirect: '/' }

            }

        }
        if (choice == 'consumer') {
            const [user] = await con.query('select User_Name from consumers where User_Name=?', [username])
            if (user[0].User_Name == username) {
                console.log('user aldready exits')
                return { redirect: '/', alertMessage: "consumer aldready exists" }
            } else {
                await con.query('insert into consumers (User_Name,Name,Street,District,Pincode,Contact_Number,Password) values(?,?,?,?,?,?,?)', [username, name, street, district, pincode, contact, password])
                return { redirect: '/' }

            }


        }
    }
}


export default validateUser