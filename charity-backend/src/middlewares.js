import { query } from "./db.js";

function validateUser(req, res, next) {
  const userId = req.headers.userid;
  const userIds = query(`SELECT * FROM users`).map(({ id }) => id);

  if (!userId) {
    return res.status(401).json({
      status: 401,
      error: "Missing header",
      message: "UserID header is missing.",
    });
  }

  if (!userIds.includes(userId)) {
    return res.status(401).json({
      status: 401,
      error: "Unauthorized",
      message: "User is not registered.",
    });
  }

  next();
}

export { validateUser };
