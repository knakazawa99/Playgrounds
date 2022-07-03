export default function pr20220226() {
    // レストパラメータ
    // const sum = (numbers: number[]): number => {
    //     return numbers.reduce((total, n) => total + n, 0)
    // }
    // console.log(sum([1,2, 3]))
    // // ↓
    // const sumVariadicSafe = (...numbers: number[]): number => {
    //     return numbers.reduce((total, n) => total + n, 0)
    // }
    // console.log(sumVariadicSafe(1, 2, 3))
    // console.log(sumVariadicSafe(1, 2, 3, [3, 3])) これはだめ、あくまでも数値を可変長で渡せるだけ
    // ※ レストパラメータを渡せるのは１関数1つ、当たり前か...
    
    // ジェネレータ
    // function* createFibonaccicGenerator() {
    //     let a = 0
    //     let b = 1
    //     while (true) {
    //         yield a;
    //         [a, b] = [b, a+b]
    //     }
    // }
    // let numbers = createFibonaccicGenerator()
    // console.log(numbers.next())
    // console.log(numbers.next())
    // console.log(numbers.next())
    // console.log(numbers.next())

    // 呼び出しシグネチャ
    // type Log = (message: string, userId?: string) => void
    // let log: Log = (
    //     message,
    //     userId = 'not signed in'
    // ) => {
    //     let time = new Date().toISOString()
    //     console.log(time, message, userId)
    // }
    // log('test')
    // log('test', '22')

    // 制限付きポリモーフィズム
    // type TreeNode = {
    //     value: string
    // }
    // type LeadNode = TreeNode & {
    //     isLeaf: true
    // }
    // type InnerNode = TreeNode & {
    //     children: [TreeNode] | [TreeNode, TreeNode]
    // }

    // type mapNodeFunc = (value: string) => string;
    // function mapNode<T extends TreeNode>(node: T, f: mapNodeFunc): T {
    //     return {
    //         ...node,
    //         value: f(node.value)
    //     }
    // }

    // 4の練習問題やってみる
    /**
     * 1 両方
     */

    /**
     * 2 argumentsオブジェクトは型安全ではない、レストパラメータを利用する。
     * 
     * レストパラメータには制限として、一つの関数に一つであること、対象の関数の最後のパラメータとして利用することがある。
     */

    /**
     * 3
     */
    type Reserve = {
        (from: Date, to: Date, destination: string): Reservation
        (from: Date, destination: string): Reservation
        (destination: string): Reservation
    }

    // const reserve: Reserve = (from: Date, toOrDestination, destination?) => {
    //     if (toOrDestination instanceof Date && destination != undefined) {
    //         // 予約
    //     } else if (typeof toOrDestination === 'string') {
    //         // 日帰り予約
    //     }
    // }
    // const reserve: Reserve = (fromOrDestination, toOrDestination?, destination?) {
    //     if (fromOrDestination instanceof Date && toOrDestination instanceof Date && destination != undefined) {
    //         // 宿泊予約
    //     } else if (fromOrDestination instanceof Date && typeof toOrDestination === 'string') {
    //         // 日帰り予約
    //     } else if (typeof fromOrDestination === 'string') {
    //         // 目的地のみ
    //     }
    // }

}