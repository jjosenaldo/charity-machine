import { decreaseItemQuantity, getItem } from "../models/items.js";

function pickItem(req, res) {
  const itemId = req.params.itemId;
  const item = getItem(itemId);

  if (!item)
    return res.status(404).json({
      status: 404,
      error: "Resource not found",
      message: "Item does not exist.",
    });

  if (item.quantity === 0)
    return res.status(422).json({
      status: 422,
      error: "Unprocessable action",
      message: "Item's quantity is 0.",
    });

  const userId = req.headers.userid;
  decreaseItemQuantity(userId, itemId);

  res.json({ ...item, quantity: --item.quantity });
}

export { pickItem };
