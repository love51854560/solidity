import { getDefaultConfig } from "@rainbow-me/rainbowkit";
import {
  arbitrum,
  base,
  mainnet,
  optimism,
  polygon,
  sepolia,
} from "wagmi/chains";
import { http } from "wagmi";

export const config = getDefaultConfig({
  appName: "my-rainbowkit-app",
  projectId: "f4ce83dc1594cf774d116c798b4864d0",
  chains: [mainnet, polygon, optimism, arbitrum, base, sepolia],
  transports: {
    // 替换之前 不可用的 https://rpc.sepolia.org/
    [sepolia.id]: http("https://sepolia.infura.io/v3/" + process.env.NEXT_PUBLIC_INFURA_ID),
  },
  ssr: true,
});
