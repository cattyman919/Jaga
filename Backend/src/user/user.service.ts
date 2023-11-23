import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository, SelectQueryBuilder } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { isEmpty } from 'class-validator';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) { }

  getUserQueryBuilder(): SelectQueryBuilder<User> {
    return this.usersRepository.createQueryBuilder('user');
  }
  async create(userData: CreateUserDto) {
    const newUser = await this.usersRepository.create(userData);
    await this.usersRepository.save(newUser);
    return newUser;
  }

  async findAll(): Promise<User[]> {
    return await this.usersRepository.find();
  }

  async findOneByUsername(username: string): Promise<User> {
    try {
      return await this.usersRepository.findOneBy({ username });
    } catch (error) {
      throw error;
    }

  }

  async findOneByEmail(email: string): Promise<User> {
    try {
      return await this.usersRepository.findOneBy({ email });
    } catch (error) {
      throw error;
    }

  }

  async findOneById(id: number) {
    try {
      const user = await this.usersRepository.findOneBy({ id });
      if (user) return user;
      throw new HttpException(
        'User with this id does not exist',
        HttpStatus.NOT_FOUND,
      );
    } catch (error) {
      throw error;
    }
  }

  async update(id: number, updateUserDto: UpdateUserDto) {
    const { fullName, password, username } = updateUserDto;

    if (fullName == null && password == null && username == null) {
      throw new HttpException("Body is empty!", HttpStatus.BAD_REQUEST);
    }

    if (updateUserDto.password) {
      updateUserDto.password = await bcrypt.hash(updateUserDto.password, 10);
    }

    await this.findOneById(id);
    try {
      await this.usersRepository.update({ id }, updateUserDto);
    } catch (error) {
      throw error;
    }
    return await this.findOneById(id);
  }

  async remove(id: number) {
    return await this.usersRepository.delete({ id })
  }

}
