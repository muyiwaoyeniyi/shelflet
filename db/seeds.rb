# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


	conditions = Condition.create([{ name: 'New' }, { name: 'Used - Excellent' }, { name: 'Used - Minor Blemish' }, { name: 'Used - Some missing pages' }, { name: 'Used - Barely legal' }])

	categories = Category.create([{ name: 'Accounting' }, { name: 'Architecture' }, { name: 'Art History' }, { name: 'Business & Finance' }, { name: 'Computer Science' }, { name: 'Communication & Journalism' }, { name: 'Design' }, { name: 'Economics' }, { name: 'Education' }, { name: 'Engineering' }, { name: 'Foreign Languages' }, { name: 'History' }, { name: 'Humanities' }, { name: 'Law' }, { name: 'Literature' }, { name: 'Mathematics' }, { name: 'Medicine & Health Sciences' }, { name: 'Nursing' }, { name: 'Philosophy' }, { name: 'Political Science' }, { name: 'Psychology' }, { name: 'Sciences' }, { name: 'Reference' }, { name: 'Religious Studies' }, { name: 'Visual Arts' }, { name: 'Test Prep & Study Guides' } ])