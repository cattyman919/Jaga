import { PassportSerializer } from '@nestjs/passport'

export class SessionSerializer extends PassportSerializer {
    serializeUser(user: any, done: (error: Error, user: any) => void) {
        console.log("Serialize User")
        done(null, user)
    }

    deserializeUser(payload: any, done: (error: Error, payload: string) => void) {
        console.log("deSerialize User")
        done(null, payload)
    }
}