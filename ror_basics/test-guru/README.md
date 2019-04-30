# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.5.0

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite
rspec

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Data structure

Ticket
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :questionaries

QuestionType
  has_many :questions
  name: string

Question
  has_and_belongs_to_many :tickets
  belongs_to :question_type

  text: string

User
  has_and_belongs_to_many :roles
  login: string
  password: string
  email: string

Role
  has_and_belongs_to_many :users
  has_and_belongs_to_many :abilities

Ability
  has_and_belongs_to_many :roles

Questionary
  belongs_to :user
  has_and_belongs_to_many :tickets
