import { Vehicle } from 'src/vehicles/entities/vehicle.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Exclude } from 'class-transformer';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  @Exclude()
  id: number;

  @Column({ nullable: false })
  username: string;

  @Column({ nullable: false })
  @Exclude()
  password: string;

  @Column({ nullable: false, unique: true })
  email: string;

  @Column({ name: 'fullname', default: '' })
  fullName: string;

  @OneToMany(() => Vehicle, (vehicle) => vehicle.user, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  })
  vehicles: Vehicle;
}
