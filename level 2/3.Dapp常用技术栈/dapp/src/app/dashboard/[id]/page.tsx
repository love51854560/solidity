import DetailComponent from "./components/DetailComponent";

const DetailPage = async ({params}:{params:Promise<{id:string}>}) => {
  // console.log(datas);
  const id = (await params).id;

  return (
    <>
      {id == '1' && <DetailComponent />}
      {id}
      <h2>带参数的路由</h2>
    </>
  );
};

export default DetailPage;
