import { OmitType, PartialType } from '@nestjs/mapped-types';
import { CreateUserDto } from './create-user.dto';
import { IsOptional } from 'class-validator';

export class UpdateUserDto extends OmitType(CreateUserDto, ['email'] as const) {
    @IsOptional()
    username: string;

    @IsOptional()
    password: string;

    @IsOptional()
    fullName: string;
}
