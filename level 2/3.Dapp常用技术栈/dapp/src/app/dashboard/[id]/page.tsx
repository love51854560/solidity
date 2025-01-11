import DetailComponent from "./components/DetailComponent";

const DetailPage = async (datas: any) => {
  return (
    <>
      <DetailComponent />
      {datas.params.id}
      <h2>带参数的路由</h2>
    </>
  );
};

export default DetailPage;
