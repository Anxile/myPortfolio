import React, { useState } from "react";
import Alert from "./components/Alert";
import "bootstrap/dist/css/bootstrap.min.css";
function App() {
  const [altervisible, setalertvisibility] = useState(false);
  return (
    <>
      {altervisible && (
        <Alert onClose={() => setalertvisibility(false)}>Alert</Alert>
      )}
      <button
        type="button"
        className="btn btn-primary"
        onClick={() => setalertvisibility(true)}
      >
        Primary
      </button>
    </>
  );
}

export default App;
