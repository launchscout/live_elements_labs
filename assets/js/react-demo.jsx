import React, {useState} from "react"
import useLiveState from "./useLiveState"

export const ReactDemo = () => {
  const [globalUpdates, setGlobalUpdates] = useState([]);

  const clobberColors = (color) => {
    const message = `Setting everyone's color to ${color}`

    // let's update this line to actually broadcast
    console.log(message)

    addGlobalUpdate(message)
  }

  const addGlobalUpdate = (message) => {
    setGlobalUpdates([...globalUpdates, message])
  }

  // We also need to handle an incoming message

  const colors = ["red", "blue", "green", "purple"]

  return(
    <div>
      <h1>Clobber Everyone's Color</h1>

      {colors.map((color) =>
        <button
          key={color}
          onClick={() => clobberColors(color)}
          className="bg-zinc-900 text-white px-3 font-semibold rounded-lg"
        >
          Make it {color}
        </button>
      )}

      <ul>
        {globalUpdates.map((updateMessage) => <li>{updateMessage}</li>)}
      </ul>
    </div>
  );
}
