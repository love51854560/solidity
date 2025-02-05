'use client';

import React, { useRef } from 'react';

interface CusTomInputProps extends React.InputHTMLAttributes<HTMLInputElement>{}

const CustomInput = React.forwardRef<HTMLInputElement,CusTomInputProps>((props,ref) => {
  return <input ref={ref} {...props} />;
})

const ForwardRefComponent = () => {
  const inputRef = useRef<HTMLInputElement>(null);

  const focusInput = () => {
    if (inputRef.current) {
      inputRef.current.focus();
    }
  };

  return (
    <div>
      <CustomInput ref={inputRef} placeholder="Focus me" />
      <button onClick={focusInput}>Focus the Input</button>
    </div>
  );
}

export default ForwardRefComponent;