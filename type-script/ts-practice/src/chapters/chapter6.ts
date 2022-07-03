// 6.1
export default function chapter6() {
    type ExistingUser = {
        id: number
        name: string
    }
    
    type NewUser = {
        name: string
    }
    
    const deleteUser = (user: {id?: number, name: string}) => {
        delete user.id
    }
    
    let exisitingUser: ExistingUser = {
        id: 123456,
        name: "Ima User"
    }
    
    console.log(exisitingUser)
    deleteUser(exisitingUser)
    
    console.log(exisitingUser)

    // type LegacyUser = {
    //     id?: number | string
    //     name: string
    // }

    // let legacyUser: LegacyUser = {
    //     id: '793331',
    //     name: 'Xin Yang'
    // }
    // console.log(legacyUser)
    // deleteUser(legacyUser)

    class Animal {}
    class Bird extends Animal {
        chirp() {}
    }
    class Crow extends Bird{
        caw() {}
    }
    const chirp = (bird: Bird): Bird => {
        bird.chirp()
        return bird
    }
    // chirp(new Animal())
    // chirp(new Bird())
    // chirp(new Crow())

    const clone = (f: (b: Bird) => Bird): void => {

    }
    const birdToBird = (b: Bird): Bird => {
        return b
    }
    clone(birdToBird)
    const birdToCrow = (b: Bird): Crow => {
        return new Crow()
    }
    clone(birdToCrow)
    const birdToAnimal = (b: Bird): Animal => {
        return new Animal()
    }
    // clone(birdToAnimal)

    // 6.2
    // 完全性(totality),
    // 網羅チェック(exhaustiveness checking)
    // switch, if, throwが使用されていて、tsは全ての型をチェックしてくれる
    type Weekday = 'Mon' | 'Tue' | 'Wed' | 'Thu' | 'Fri'
    type Day = Weekday | 'Sat' | 'Sun'

    // function getNextDay(w: Weekday): Day {
    //     switch (w) {
    //         case 'Mon' : return 'The'
    //     }
    // }
    const isBig = (n: number): boolean => {
        if (n >= 100) {
            return true
        }
        return false
    }

    // 6.3 
    
    // ルックアップ型
    type APIResponcse = {
        user: {
            userId: string
            friendList: {
                count: number
                friends: {
                    firstName: string
                    lastName: string
                }[]
            }
        }
    }
    // ルックアップ型は下記のように、ある型の中のキーを指定して型を定義すること
    type FriendList = APIResponcse['user']['friendList']
    // もちろん、FriendListの型を別途定義し、APIResponseの方を書き換えることも可能
    // type APIResponcse = {
    //     user: {
    //         userId: string
    //         friendList: FriendList
    //     }
    // }

    // keyof
    type ResponseKeys = keyof APIResponcse // 'user'
    type UserKeys = keyof APIResponcse['user']  // 'userId' | 'friendList'
    type FriendListKeys = keyof APIResponcse['user']['friendList'] // 'count' | 'friends'

    const get = <O extends  object, K extends keyof O>(o: O, k: K): O[K] => {
        return o[k]
    }

    type ActivityLog = {
        lastEvent: Date
        events: {
            id: string
            timestamp: Date
            type: 'Read' | 'Write'
        }
    }

    let activityLog: ActivityLog = {
        lastEvent: new Date(),
        events: {
            id: 'test',
            timestamp: new Date(),
            type: 'Read'
        }
    }
    let lastEvent = get(activityLog, 'lastEvent')
}
