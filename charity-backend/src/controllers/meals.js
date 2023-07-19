import { getAvailableMeals } from "../models/meals.js";
import { getAvailableItems } from "../models/items.js";

function getMeals(req, res) {
  const userId = req.headers.authorization;

  // get all meals that were not retrieved yet
  const availableMeals = getAvailableMeals(userId);

  let body = { meals: availableMeals };

  // if the items parameter was specified, return the available items as well
  if (req.query.items) {
    body = {
      ...body,
      items: getAvailableItems(availableMeals.map(({ id }) => id)),
    };
  }

  res.json(body);
}

function getMealItems(req, res) {
  res.json({ items: getAvailableItems([req.params.mealId]) });
}

export { getMeals, getMealItems };
