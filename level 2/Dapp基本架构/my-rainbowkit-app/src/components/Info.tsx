import { formatUnits, parseUnits } from "viem";
import { useAccount, useBalance } from "wagmi";

const Info = () => {
  const { address } = useAccount();
  const { data, error } = useBalance({ address });
  const { data: rccTokenData } = useBalance({
    address,
    token: "0x169b0CBD28Eb4B086F5Cf58DDa0Ea3A25fadcA0b",
  });
  console.log(data, "balance");
  return (
    <div>
      <div>Address:{address}</div>
      {data && (
        <div>
          ETH Balance: {data?.formatted} ------- formatted
          {formatUnits(data?.value, 18)}
        </div>
      )}
      <div>Rcc Balance: {rccTokenData?.formatted}</div>
    </div>
  );
};

export default Info;
