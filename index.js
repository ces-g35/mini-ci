import express from "express";

const app = express();
const PORT = 3003;

app.use(express.json());

app.post('', (req, res) => {
  console.log(req.body);
  res.status(200).end();
})

app.listen(PORT, () => {
  console.log(`listening on port ${PORT}`);
})
