import express from "express"
import { dirname } from "path";
import path from "path";
import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));



const app = express()
const port = 3000
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
//controllers
import validateUser from "./controllers/loginAccess.js";
import productRequest from "./controllers/product_requests.js";
//routes
import consumerRouter from "./routes/consumer_routes.js";
import farmerRouter from "./routes/farmer_routes.js"
import productRouter from "./routes/product_routes.js";
//using middlewares
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }))
app.use(express.json());



//using routers
app.use('/consumer', consumerRouter)
app.use('/farmer', farmerRouter)
app.use('/product', productRouter)

//api routers
app.use('/api', productRequest)


app.get('/', (req, res) => {
    res.render('index.ejs', {
        districts: districts
    })
})

app.post('/', async (req, res) => {
    const resObj = await validateUser(req, res)
    console.log(resObj);
    res.json(resObj)
})


const districts = ["Ariyalur",
    "Chengalpattu",
    "Chennai",
    "Coimbatore",
    "Cuddalore",
    "Dharmapuri",
    "Dindigul",
    "Erode",
    "Kallakurichi",
    "Kancheepuram",
    "Karur",
    "Krishnagiri",
    "Madurai",
    "Mayiladuthurai",
    "Nagapattinam",
    "Kanniyakumari",
    "Namakkal",
    "Nilgiris",
    "Perambalur",
    "Pudukkottai",
    "Ramanathapuram",
    "Ranipet",
    "Salem",
    "Sivagangai",
    "Tenkasi",
    "Thanjavur",
    "Theni",
    "Thoothukudi",
    "Tiruchirappalli",
    "Tirunelveli",
    "Tirupattur",
    "Tiruppur",
    "Tiruvallur",
    "Tiruvannamalai",
    "Tiruvarur",
    "Vellore",
    "Viluppuram",
    "Virudhunagar"]



app.listen(port, () => {
    console.log(`listnening to the port ${port}`);
})
