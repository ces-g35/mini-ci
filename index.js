import express from "express"
import { exec } from "node:child_process"
import * as dotenv from "dotenv"

const app = express()
const PORT = 5000

dotenv.config()

dotenv.config({ path: `/home/ubuntu/${process.env.REPOSITORY_BASE}/.env` })

app.use(express.json())

app.post("", (req, res) => {
  console.log(req.body)

  exec("./mini-ci/update.sh", {
    cwd: "/home/ubuntu",
  })

  res.status(200).end()
})

app.post("/aws", (req, res) => {
  const { aws_secret_access_key, aws_access_key_id, aws_session_token } =
    req.body

  if (!aws_access_key_id || !aws_secret_access_key || !aws_session_token) {
    return res
      .status(400)
      .send(
        "expect aws_secret_access_key, aws_access_key_id, aws_session_token"
      )
  }

  // TODO: Security lmao

  exec(
    `./mini-ci/replace_env.sh AWS_ACCESS_KEY_ID=${aws_access_key_id} AWS_SECRET_ACCESS_KEY=${aws_secret_access_key} AWS_SESSION_TOKEN=${aws_session_token}`,
    {
      cwd: "/home/ubuntu",
    }
  )
  exec("./restart.sh")

  console.log(req.body)
  res.status(200).end()
})

app.listen(PORT, () => {
  console.log(`listening on port ${PORT}`)
})
