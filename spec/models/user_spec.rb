require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'email、password、password_confirmation、family_name、last_name、family_name_kana、last_name_kana、birth_date、nickname、prefecture_id、sexual_identity_id、sexual_orientation_1_id、height、body_type_id、purpose_id、self_prが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'sexual_orientation_2_idは空でも保存できること' do
        @user.sexual_orientation_2_id = ''
        expect(@user).to be_valid
      end
      it 'sexual_orientation_3_idは空でも保存できること' do
        @user.sexual_orientation_3_id = ''
        expect(@user).to be_valid
      end
      it 'sexual_orientation_4_idは空でも保存できること' do
        @user.sexual_orientation_4_id = ''
        expect(@user).to be_valid
      end
      it 'sexual_orientation_5_idは空でも保存できること' do
        @user.sexual_orientation_5_id = ''
        expect(@user).to be_valid
      end
      it 'sexual_orientation_6_idは空でも保存できること' do
        @user.sexual_orientation_6_id = ''
        expect(@user).to be_valid
      end
      it 'sexual_orientation_7_idは空でも保存できること' do
        @user.sexual_orientation_7_id = ''
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは6文字以上でないと登録できない' do
        @user.password = 'test0'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'Passwordは半角数字のみでは登録できない' do
        @user.password = '0000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'Passwordは半角英字のみでは登録できない' do
        @user.password = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'Passwordは全角文字を含むと登録できない' do
        @user.password = 'パスワード1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'test000'
        @user.password_confirmation = 'test001'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'family_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.family_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'Ichiro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end
      it 'family_name_kanaが空欄では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'family_name_kanaはカタカナでないと登録できない' do
        @user.family_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana 全角カタカナを使用してください')
      end
      it 'last_name_kanaが空欄では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaはカタカナでないと登録できない' do
        @user.last_name_kana = '一郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end
      it 'birth_dateは空欄では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'prefecture_idが空では登録できない' do
        @user.prefecture_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県に「---」が選択されている場合は登録できない' do
        @user.prefecture_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'gender_identity_idが空では登録できない' do
        @user.gender_identity_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Gender identity can't be blank")
      end
      it '性自認に「---」が選択されている場合は登録できない' do
        @user.gender_identity_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Gender identity can't be blank")
      end
      it 'sexual_orientation_1_idが空では登録できない' do
        @user.sexual_orientation_1_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Sexual orientation 1 can't be blank")
      end
      it '性的指向に「---」が選択されている場合は登録できない' do
        @user.sexual_orientation_1_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Sexual orientation 1 can't be blank")
      end
      it 'heightが空では登録できない' do
        @user.height = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Height can't be blank")
      end
      it 'body_type_idが空では登録できない' do
        @user.body_type_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Body type can't be blank")
      end
      it '体型に「---」が選択されている場合は登録できない' do
        @user.body_type_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Body type can't be blank")
      end
      it 'purpose_idが空では登録できない' do
        @user.purpose_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Purpose can't be blank")
      end
      it '利用目的に「---」が選択されている場合は登録できない' do
        @user.purpose_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Purpose can't be blank")
      end
      it 'self_prが空では登録できない' do
        @user.self_pr = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Self pr can't be blank")
      end
    end
  end
end

