"use client";

import React, { useEffect } from "react";
import Son from "./son";

type DeepMethodType = () => void;

const DeepMethodContext = React.createContext<DeepMethodType | null>(null);

const Parent = () => {
  let from = "parent";
  const handleDeepMethod = () => {
    console.log(from);
    console.log("调用了深层子组件的方法");
  };
  const handleDeepMethod2 = () => {
    console.log(from);
    console.log("调用了深层子组件的方法2");
  };
  const handleDeepMethod3 = () => {
    console.log(from);
    console.log("调用了深层子组件的方法3");
  };
  useEffect(() => {
    window.addEventListener("deepMethodTriggered", handleDeepMethod3);
    return () => {
      window.removeEventListener("deepMethodTriggered", handleDeepMethod3);
    };
  },[]);
  return (
    <>
      <DeepMethodContext.Provider value={handleDeepMethod2}>
        <Son onDeepMethod={handleDeepMethod}></Son>
      </DeepMethodContext.Provider>
    </>
  );
};

export {Parent,DeepMethodContext};
