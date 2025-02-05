import { useRouter } from "next/navigation";

const Dashboard = () => {
  const router = useRouter();

  const clickButton = () => {
    router.push("/dashboard/11");
  };

  return (
    <>
      <h2>dashboard</h2>
      <button onClick={clickButton}>跳转</button>
    </>
  );
};

export default Dashboard;
