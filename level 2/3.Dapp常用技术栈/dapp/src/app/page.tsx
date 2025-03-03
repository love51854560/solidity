import Image from "next/image";
import {Parent} from "./components/deepMethods/parent";
import ForwardRefComponent from "./components/fowardRef";

export default function Home() {
  return (
    <>
      <Parent></Parent>
      <ForwardRefComponent></ForwardRefComponent>
    </>
  );
}
