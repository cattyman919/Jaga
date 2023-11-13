import { Vehicle } from 'src/vehicles/entities/vehicle.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  username: string;

  @Column({ nullable: false })
  password: string;

  @Column({ nullable: false, unique: true })
  email: string;

  @Column({ name: 'firstname', default: '' })
  firstName: string;

  @Column({ name: 'lastname', default: '' })
  lastName: string;

  @Column()
  access_token: string

  @OneToMany(() => Vehicle, (vehicle) => vehicle.user, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  })
  vehicles: Vehicle;
}
