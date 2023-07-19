import express from "express";
import router from "./src/router.js";
import { validateUser } from "./src/middlewares.js";

const app = express();
const port = 8080 || process.env.PORT;

app.use(express.json());
app.use(validateUser);
app.use("/", router);

app.listen(port, () => {
  console.log(`Backend listening at http://localhost:${port}`);
});

export default app;
