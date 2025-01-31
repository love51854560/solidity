import Link from "next/link";

const Team = () => {
    return (
        <Link href="/dashboard2/setting">setting</Link>
    )
}

const f2:(n1:number) => number = n1 => {
    return n1
}

interface ILength{
    length:number
}

function getLength<T extends ILength>(args:T){
    return args.length
}

getLength('hello')
getLength([1,2,3])
getLength({length:1,name:'111'})

type TypeofMsg<T> = T extends {msg:unknown} ? T['msg'] : never

const m:TypeofMsg<{msg:string}> = '11';
const email:TypeofMsg<{msg:number,name:string}> = 11;

type Filter<T,U> = T extends U ? never : T;

export default Team;