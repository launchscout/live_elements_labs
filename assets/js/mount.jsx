import React from "react";
import { render, unmountComponentAtNode } from "react-dom";

import { ReactDemo } from "./react-demo";

export function mount(id, opts = {}) {
  const rootElement = document.getElementById(id);

  render(
    <React.StrictMode>
      <ReactDemo {...opts} />
    </React.StrictMode>,
    rootElement
  );

  return (el) => {
    if (!unmountComponentAtNode(el)) {
      console.warn("unmount failed", el);
    }
  };
}
