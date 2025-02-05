'use client';

import GrandSon from "./grandSon";

interface SonProps {
  onDeepMethod: () => void;
}

const Son = ({ onDeepMethod }: SonProps) => {
  return (
    <>
      <GrandSon onDeepMethod={onDeepMethod}></GrandSon>
    </>
  );
};

export default Son;
