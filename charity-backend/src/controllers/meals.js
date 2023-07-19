import { getAvailableMeals } from "../models/meals.js";
import { getAvailableItems } from "../models/items.js";

function getMeals(req, res) {
  const userId = req.headers.userid;

  // get all meals that were not retrieved yet
  const availableMeals = getAvailableMeals(userId);
  const availableItems = getAvailableItems(
    userId,
    availableMeals.map(({ id }) => id)
  );

  const body = { meals: availableMeals, items: availableItems };

  res.json(body);
}

export { getMeals };
