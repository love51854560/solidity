"use client";

import React from "react";
import { DeepMethodContext } from "./parent";

interface SonProps {
  onDeepMethod: () => void;
}

const GrandSon = ({ onDeepMethod }: SonProps) => {
  const deepMethod = () => {
    console.log("深层子组件的方法被执行了");
    onDeepMethod();
  };
  const handleDeepMethod2 = React.useContext(DeepMethodContext);
  const deepMethod2 = () => {
    console.log("深层子组件的方法被执行了2");
    if (handleDeepMethod2) {
      handleDeepMethod2();
    }
  };
  const deepMethod3 = () => {
    console.log("深层子组件的方法被执行了3");
    const event = new CustomEvent("deepMethodTriggered");
    window.dispatchEvent(event);
  };
  return (
    <>
      <button onClick={deepMethod}>触发深层方法</button>
      <button onClick={deepMethod2}>触发深层方法2</button>
      <button onClick={deepMethod3}>触发深层方法3</button>
    </>
  );
};

export default GrandSon;
