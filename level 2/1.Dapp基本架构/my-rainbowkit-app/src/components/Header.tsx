import { ConnectButton } from "@rainbow-me/rainbowkit";
import Styles from "../styles/Home.module.css";

const Header = () => {
  return (
    <div className={Styles.header}>
      <div>Dapp Frontend</div>
      <div>
        <ConnectButton />
      </div>
    </div>
  );
};

export default Header;
