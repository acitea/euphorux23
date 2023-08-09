import express from 'express'
import dotenv from 'dotenv'
dotenv.config();


import Router from "./utils/router.js";
import cors from "cors";
import bodyParser from "body-parser";
import cookieParser from 'cookie-parser';

const APP = express();
const port = parseInt(process.env.PORT) || 8080;


APP.use(bodyParser.json())
APP.use(bodyParser.urlencoded({ extended: false }))
APP.use(cookieParser())
APP.use(cors(
    {
        credentials: true,
        origin: process.env.ORIGINS,
    }
    ));
APP.use(Router);

APP.get('/', (req, res) => {
    res.send('<h1>MAIN</h1>');
});

APP.listen(port, () => {
    console.log(`Now listening on port ${port}`); 
});
