import { CanActivate, ExecutionContext, HttpException, HttpStatus, Injectable } from '@nestjs/common'

@Injectable()
export class AuthenticationGuard implements CanActivate {
    async canActivate(context: ExecutionContext) {
        const request = context.switchToHttp().getRequest()
        if (!request.isAuthenticated()) throw new HttpException({
            message: "Log in to account first",
            error: "Unauthorized",
            status: HttpStatus.UNAUTHORIZED
        }, HttpStatus.UNAUTHORIZED)
        return true
    }
}