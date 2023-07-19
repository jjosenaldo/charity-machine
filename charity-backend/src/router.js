import { Router } from "express";
import { getMeals, getMealItems } from "./controllers/meals.js";
import { pickItem } from "./controllers/items.js";

const router = Router();

router.get("/meals", getMeals);

router.get("/meals/:mealId/items", getMealItems);

router.post("/items/pick/:itemId", pickItem);

export default router;
