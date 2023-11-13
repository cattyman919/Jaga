import { Vehicle } from 'src/vehicles/entities/vehicle.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Exclude } from 'class-transformer';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  username: string;

  @Column({ nullable: false })
  @Exclude()
  password: string;

  @Column({ nullable: false, unique: true })
  email: string;

  @Column({ name: 'firstname', default: '' })
  firstName: string;

  @Column({ name: 'lastname', default: '' })
  lastName: string;

  @OneToMany(() => Vehicle, (vehicle) => vehicle.user, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  })
  vehicles: Vehicle;
}
