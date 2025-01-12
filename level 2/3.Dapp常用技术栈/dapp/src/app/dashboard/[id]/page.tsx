import DetailComponent from "./components/DetailComponent";

const DetailPage = async (params: any) => {
  const { id } = params;

  // 模拟 API 请求
  const fetchData = (id: any) => {
    return new Promise((resolve) => {
      resolve({
        data: {
          name: "1111",
          code: "2222",
        },
      });
    });
  };
  const detail: any = await fetchData(id);

  return (
    <>
      <DetailComponent />
      <h1>{detail.data.code}</h1>
      <h2>带参数的路由</h2>
    </>
  );
};

export default DetailPage;
