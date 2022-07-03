export default function chapter3() {

    // 2022.02.26 目的は理解の薄い部分の型、1度目ではスルーした言語機能について理解すること

    // Symbol
    let a = Symbol('a')
    let b: symbol = Symbol('b')
    var c = a == b
    console.log('c: ', c)
    var d = a === b
    console.log('c: ', c)
}