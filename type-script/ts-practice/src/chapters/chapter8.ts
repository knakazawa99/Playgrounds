import { rejects } from 'assert'
import * as fs from 'fs'
import { resolve } from 'path/posix'

const chapter8 = async () => {
    // Chapter 8
    // 並行、並列処理

    console.log("chapter 8")

    // // イベントループ
    // setTimeout(() => console.info('A'), 1)
    // setTimeout(() => console.info('B'), 2)
    // console.info('C')

    // コールバック
    // 引数として渡される通常の関数

    
    // fs.readFile(
    //     '/var/log/apache2/access_log', { encoding: 'utf-8' }, (error, data) => {
    //         if (error) {
    //             console.error('error reading!', error)
    //             return
    //         }
    //         console.info('success reading!', data)
    //     }
    // )

    // fs.appendFile(
    //     '/var/log/apache2/access_log', 'New access entry', (error) => {
    //         if (error) {
    //             console.error('error writing!', error)
    //         }
    //     }
    // )

    // Promise
    // class Promise {
    //     constructor(f: Executor) {}
    // }

    // type Executor = (
    //     resolve: Function,
    //     reject: Function
    // ) => void

    // function readFilePromise(path: string): Promise<string> {
    //     return new Promise((resolve, reject) => {
    //         fs.readFile(path, (error, result) => {
    //             if (error) {
    //                 reject(error)
    //             } else {
    //                 resolve(result)
    //             }
    //         })
    //     })
    // }

    // // 呼び出しシグネチャ
    // type Executor<T, E extends Error> = (
    //     resolve: (result: T) => T,
    //     reject: (error: E) => void
    // ) => void
    // class Promise<T, E extends Error> {
    //     constructor(f: Executor<T, E>) {}
        
    //     then<U, F extends Error>(g: (result: T) => Promise<U, F> | U): Promise<U, F>
    //     catch<U, F extends Error>(g: (error: E) => Promise<U, F> | U): Promise<U, F>

    // }

    // 以下の三つは動かすために、自分で作成
    type User = {
        name: string
        userId: number,
        location: string
    }
    const getLocation = async (user: User): Promise<string> => {
        return user.location
    }
    const getUserID = async (userId: number): Promise<User> => {
        const user: User = {
            name: 'kensuke',
            userId: userId,
            location: 'niiggata'
        }
        return user
    }

    const getUser = async () => {
        getUserID(18)
            .then(user => getLocation(user))
            .then(location => console.log('get lcaotion', location))
            .catch(error => console.error(error))
            .finally(() => console.info('done getting location'))
    }

    const getUser2 = async () => {
        try {
            let user = await getUserID(18)
            let location = await getLocation(user)
            console.log('2 got location', user)
        } catch (error) {
            console.error(error)
        } finally {
            console.info('2 done getting location')
        }
    }
    await getUser()
    await getUser2()

}

export default chapter8