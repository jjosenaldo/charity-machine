import { Router } from "express";
import { getMeals } from "./controllers/meals.js";
import { pickItem } from "./controllers/items.js";

const router = Router();

router.get("/meals", getMeals);

router.post("/items/pick/:itemId", pickItem);

export default router;
